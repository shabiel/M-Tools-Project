package gov.va.med.iss.meditor.command;

import gov.va.med.foundations.adapter.cci.VistaLinkConnection;
import gov.va.med.iss.connection.actions.VistaConnection;
import gov.va.med.iss.connection.utilities.ConnectionUtilities;
import gov.va.med.iss.meditor.Messages;
import gov.va.med.iss.meditor.core.RoutineDirectory;
import gov.va.med.iss.meditor.dialog.InputDialogHelper;
import gov.va.med.iss.meditor.dialog.MessageConsoleHelper;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;

public class ReportRoutineDirectory extends AbstractHandler {
	@Override
	public Object execute(final ExecutionEvent event) throws ExecutionException {
		VistaLinkConnection connection = VistaConnection.getConnection();
		if (connection == null) {
			return null;
		}
		
		String title = Messages.bind(Messages.LOAD_RTNDIR_DLG_TITLE, ConnectionUtilities.getServer(), ConnectionUtilities.getPort());
		String namespace = InputDialogHelper.getRoutineNamespace(title);
		if (namespace == null) {
			return null;
		}
		
		String result = RoutineDirectory.getRoutineNames(namespace);
		MessageConsoleHelper.writeToConsole(MessageConsoleHelper.MEDITOR, result, true);
		return null;
	}
}
